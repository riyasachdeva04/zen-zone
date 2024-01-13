// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract PsychologistProfile {
    struct Psychologist {
        string name;
        string contactNumber;
        string email;
        string specialization;
    }

    mapping(address => Psychologist) public psychologists;

    function setPsychologistProfile(string memory _name, string memory _contactNumber, string memory _email, string memory _specialization) public {
        Psychologist memory newPsychologist = Psychologist({
            name: _name,
            contactNumber: _contactNumber,
            email: _email,
            specialization: _specialization
        });
        psychologists[msg.sender] = newPsychologist;
    }

    function getPsychologistProfile() public view returns (Psychologist memory) {
        return psychologists[msg.sender];
    }
}
