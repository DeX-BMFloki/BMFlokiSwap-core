pragma solidity =0.5.16;

import './interfaces/IBMFlokiFactory.sol';
import './BMFlokiPair.sol';

contract BMFlokiFactory is IBMFlokiFactory {
    address public feeTo;
    address public feeToSetter;
    uint8 public protocolFeeDenominator = 2; // uses ~10% of each swap fee
    uint32 public swapFee = 2; // uses 0.20% fee as default

    mapping(address => mapping(address => address)) public getPair;
    address[] public allPairs;

    bytes32 public constant INIT_CODE_PAIR_HASH = keccak256(abi.encodePacked(type(BMFlokiPair).creationCode));

    event PairCreated(address indexed token0, address indexed token1, address pair, uint256);

    constructor(address _feeToSetter) public {
        feeToSetter = _feeToSetter;
    }

    function allPairsLength() external view returns (uint256) {
        return allPairs.length;
    }

    function createPair(address tokenA, address tokenB) external returns (address pair) {
        require(tokenA != tokenB, 'BMFloki: IDENTICAL_ADDRESSES');
        (address token0, address token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);
        require(token0 != address(0), 'BMFloki: ZERO_ADDRESS');
        require(getPair[token0][token1] == address(0), 'BMFloki: PAIR_EXISTS'); // single check is sufficient
        bytes memory bytecode = type(BMFlokiPair).creationCode;
        bytes32 salt = keccak256(abi.encodePacked(token0, token1));
        assembly {
            pair := create2(0, add(bytecode, 32), mload(bytecode), salt)
        }
        IBMFlokiPair(pair).initialize(token0, token1);
        getPair[token0][token1] = pair;
        getPair[token1][token0] = pair; // populate mapping in the reverse direction
        allPairs.push(pair);
        emit PairCreated(token0, token1, pair, allPairs.length);
    }

    function setFeeTo(address _feeTo) external {
        require(msg.sender == feeToSetter, 'BMFloki: FORBIDDEN');
        feeTo = _feeTo;
    }

    function setFeeToSetter(address _feeToSetter) external {
        require(msg.sender == feeToSetter, 'BMFloki: FORBIDDEN');
        feeToSetter = _feeToSetter;
    }

    function setProtocolFee(uint8 _protocolFeeDenominator) external {
        require(msg.sender == feeToSetter, 'BMFlokiFactory: FORBIDDEN');
        require(_protocolFeeDenominator > 0, 'BMFlokiFactory: FORBIDDEN_FEE');
        protocolFeeDenominator = _protocolFeeDenominator;
    }

    function setSwapFee(uint32 _swapFee) external {
        require(msg.sender == feeToSetter, 'BMFlokiFactory: FORBIDDEN');
        require(_swapFee <= 1000, 'BMFlokiFactory: FORBIDDEN_FEE');
        swapFee = _swapFee;
    }
}
