// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import '@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol';
import '@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Factory.sol';
import '@uniswap/v2-core/contracts/interfaces/IUniswapV2Pair.sol';
import '@openzeppelin/contracts/token/ERC20/IERC20.sol';

contract UniswapDapp {
    IUniswapV2Router02 public uniswapRouter;
    address public factory;

    constructor(address _router, address _factory) {
        uniswapRouter = IUniswapV2Router02(_router);
        factory = _factory;
    }

    function swapTokens(
        address _tokenIn,
        address _tokenOut,
        uint256 _amountIn,
        uint256 _amountOutMin,
        address _to,
        uint256 _deadline
    ) external {
        IERC20(_tokenIn).approve(address(uniswapRouter), _amountIn);

        uniswapRouter.swapExactTokensForTokens(
            _amountIn,
            _amountOutMin,
            getPathForToken(_tokenIn, _tokenOut),
            _to,
            _deadline
        );
    }

    function getPathForToken(address _tokenIn, address _tokenOut) private view returns (address[] memory) {
        address[] memory path = new address[](2);
        path[0] = _tokenIn;
        path[1] = _tokenOut;
        return path;
    }
}
