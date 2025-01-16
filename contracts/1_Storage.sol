// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract Storage {

    uint256 number;

    /**
     * @dev Store value in variable
     * @param num value to store
     */
    function store(uint256 num) public {
        number = num;
    }

    /**
     * @dev Return value 
     * @return value of 'number'
     */
    function retrieve() public view returns (uint256){
        return number;
    }

    function checkETHBalance(address _account) public view returns (uint256) {
        return address(_account).balance;
    }

    function giveEther(address payable _receiver) public payable {
        _receiver.transfer(msg.value);
    }

    // // Mapping to store values for each address
    // mapping(address => uint256) private values;

    // // Event to log when a value is stored
    // event ValueStored(address indexed user, uint256 value);

    // // Function to store a value
    // function storeValue(uint256 _value) public {
    //     require(values[msg.sender] == 0, "Value already set for this account");

    //     // Store the value in the mapping
    //     values[msg.sender] = _value;

    //     // Emit an event
    //     emit ValueStored(msg.sender, _value);
    // }

    // // Function to retrieve the caller's stored value
    // function getValue() public view returns (uint256) {
    //     return values[msg.sender];
    // }

    // Mapping to store a string for each address
    mapping(address => string[]) private values;

    event StringStored(address indexed user, string value);

    // Store a string associated with the sender's address
    function storeText(string calldata _value) public {
        // require(bytes(values[msg.sender]).length == 0, "Value already set for this account");
        require(bytes(_value).length > 0, "String cannot be empty");

        values[msg.sender].push(_value);

        // Emit an event
        emit StringStored(msg.sender, _value);
    }

    // Retrieve the string associated with the sender's address
    function getLatestStoredText() public view returns (string memory) {
        return values[msg.sender][values[msg.sender].length - 1];
    }

    // Retrieve all text as an array
    function retrieveAllStoredText() public view returns (string[] memory) {
        return values[msg.sender];
    }
}