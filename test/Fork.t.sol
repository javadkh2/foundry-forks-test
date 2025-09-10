import {Test, console} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";

contract ChainwebPluginTest is Test {
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

    function test_nonce_maintains_per_form() public {
        for (uint24 i = 0; i < _numberOfForks; i++) {
            uint256 forkId = _forks[i];
            vm.selectFork(forkId);
            // nonce should be 0 since this is the first transaction on this fork
            assertEq(vm.getNonce(msg.sender), 0);
            new Counter();
            // nonce should be 1 after deploying the contract
            assertEq(vm.getNonce(msg.sender), 1);
        }
    }
}