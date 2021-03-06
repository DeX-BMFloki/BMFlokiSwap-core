pragma solidity >=0.5.0;

interface IBMFlokiFactory {
    event PairCreated(address indexed token0, address indexed token1, address pair, uint256);

    function INIT_CODE_PAIR_HASH() external pure returns (bytes32);

    function feeTo() external view returns (address);

    function protocolFeeDenominator() external view returns (uint8);

    function swapFee() external view returns (uint32);

    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB) external view returns (address pair);

    function allPairs(uint256) external view returns (address pair);

    function allPairsLength() external view returns (uint256);

    function createPair(address tokenA, address tokenB) external returns (address pair);

    function setFeeTo(address) external;

    function setFeeToSetter(address) external;

    function setProtocolFee(uint8 _protocolFee) external;

    function setSwapFee(uint32) external;
}
