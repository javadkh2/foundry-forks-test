// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Counter} from "../src/Counter.sol";

contract CounterScript is Script {
    uint256[] private _forks;
    uint24 private _numberOfForks = 2;

    function setUp() public {
        // using anvil as the default fork source; so make sure anvil is running
        string memory url = "http://127.0.0.1:8545";
        for (uint24 i = 0; i < _numberOfForks; i++) {
            uint256 forkId = vm.createFork(url);
            _forks.push(forkId);
        }
    }

    // after this I'd expect to see the same address printed twice
    function run() public {

        for (uint24 i = 0; i < _numberOfForks; i++) {
            uint256 forkId = _forks[i];
            vm.selectFork(forkId);
            Counter c =   new Counter();
            console.log("Counter deployed to:", address(c));
        }


    }
}
