pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {Vm} from "forge-std/Vm.sol";
import {PoolManager} from "../../contracts/PoolManager.sol";
import {IPoolManager} from "../../contracts/interfaces/IPoolManager.sol";
import {Deployers} from "./utils/Deployers.sol";
import {ILockCallback} from "../../contracts/interfaces/callback/ILockCallback.sol";
import "forge-std/console2.sol";

contract LockDataLibraryTest is Test, Deployers, ILockCallback {
    PoolManager manager;

    function setUp() public {
        manager = Deployers.createFreshManager();
    }

    function testLockerLength() public {
        IPoolManager.LockSentinel memory sentinelDuringLockCallback =
            abi.decode(manager.lock(""), (IPoolManager.LockSentinel));
        assertEq(sentinelDuringLockCallback.length, 1);
    }

    function lockAcquired(bytes calldata) public view returns (bytes memory) {
        IPoolManager.LockSentinel memory sentinel = manager.getLockSentinel();
        console2.log("sentinel length in lockAcquired");
        console2.log(sentinel.length);
        bytes memory lockData = abi.encode(sentinel);
        return lockData;
    }
}