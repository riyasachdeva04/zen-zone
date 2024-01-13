// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

contract PatientProfile {
    struct Patient {
        string name;
        string contactNumber;
        string email;
    }

    mapping(address => Patient) public patients;

    function setPatientProfile(string memory _name, string memory _contactNumber, string memory _email) public {
        Patient memory newPatient = Patient({
            name: _name,
            contactNumber: _contactNumber,
            email: _email
        });
        patients[msg.sender] = newPatient;
    }

    function getPatientProfile() public view returns (Patient memory) {
        return patients[msg.sender];
    }
}
