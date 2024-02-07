pragma solidity >=0.7.0 < 0.9.0;

import '@openzeppelin/contracts/access/Ownable.sol';
import '@openzeppelin/contracts/utils/Counters.sol';
import '@openzeppelin/contracts/security/ReentrancyGuard.sol';

contract DappBnbx is Ownable, ReentrancyGuard  {
        using Counters for Counters.Counter;
        Counters.Counter private _totalAppartments;

        struct ApartmentStruct {
        uint id;
        string name;
        string description;
        string location;
        string images;
        uint rooms;
        uint price;
        address owner;
        bool booked;
        bool deleted;
        uint timestamp;
    }



    struct BookingStruct {
        uint id;
        uint aid;
        address tenant;
        uint date;
        uint price;
        bool checked;
        bool cancelled;
        bool abandoned;
    }

    struct ReviewStruct {
        uint id;
        uint aid;
        string reviewText;
        uint timestamp;
        address owner;
    }

    uint public securityFee;
    uint public taxPercent;

    mapping(uint => ApartmentStruct) apartments;
    mapping(uint => BookingStruct[]) bookingsOf;
    mapping(uint => ReviewStruct[]) reviewsOf;
    mapping(uint => bool) appartmentExist;
    mapping(uint => uint[]) bookedDates;
    mapping(uint => mapping(uint => bool)) isDateBooked;
    mapping(address => mapping(uint => bool)) hasBooked;

    constructor(uint _taxPercent, uint _securityFee) {
        taxPercent = _taxPercent;
        securityFee = _securityFee;
    }


    function createApartment(
        string memory name,
        string memory description,
        string memory location,
        string memory images,
        uint rooms,
        uint price
    ) public {
        require(bytes(name).length > 0, 'Name cannot be empty');
        require(bytes(description).length > 0, 'Description cannot be empty');
        require(bytes(location).length > 0, 'Location cannot be empty');
        require(bytes(images).length > 0, 'Images cannot be empty');
        require(rooms > 0, 'Rooms cannot be zero');
        require(price > 0 ether, 'Price cannot be zero');

        _totalAppartments.increment();
        ApartmentStruct memory apartment;
        apartment.id = _totalAppartments.current();
        apartment.name = name;
        apartment.description = description;
        apartment.location = location;
        apartment.images = images;
        apartment.rooms = rooms;
        apartment.price = price;
        apartment.owner = msg.sender;
        apartment.timestamp = currentTime();

        appartmentExist[apartment.id] = true;
        apartments[apartment.id] = apartment;

    }

    function currentTime() internal view returns(uint256) {
        return (block.timestamp * 1000) + 1000;
    }





}
