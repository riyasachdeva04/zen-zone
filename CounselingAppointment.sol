// SPDX-License-Identifier: MIT
pragma solidity 0.8.22;

import "@openzeppelin/contracts/access/Ownable.sol";

interface IPatientProfile {
    struct Patient {
        string name;
        string contactNumber;
        string email;
    }

    function getPatientProfile(address _patient) external view returns (Patient memory);
}

interface IPsychologistProfile {
    struct Psychologist {
        string name;
        string contactNumber;
        string email;
        string specialization;
    }

    function getPsychologistProfile(address _psychologist) external view returns (Psychologist memory);
}

contract CounselingAppointment is Ownable {
    
    struct Appointment {
        uint256 id;
        address patient;
        address psychologist;
        string dateTime;
        string location;
    }

    mapping(address => Appointment[]) public appointments;

    IPatientProfile patientProfileContract;
    IPsychologistProfile psychologistProfileContract;

    event AppointmentBooked(uint256 id, address patient, address psychologist, string dateTime, string location);
    
    constructor(address _patientProfileContract, address _psychologistProfileContract) Ownable(msg.sender) {
        patientProfileContract = IPatientProfile(_patientProfileContract);
        psychologistProfileContract = IPsychologistProfile(_psychologistProfileContract);
    }

    modifier onlyRegisteredPatient(address _patient) {
        IPatientProfile.Patient memory patient = patientProfileContract.getPatientProfile(_patient);
        require(bytes(patient.name).length > 0, "Patient not registered");
        _;
    }

    modifier onlyRegisteredPsychologist(address _psychologist) {
        IPsychologistProfile.Psychologist memory psychologist = psychologistProfileContract.getPsychologistProfile(_psychologist);
        require(bytes(psychologist.name).length > 0, "Psychologist not registered");
        _;
    }

    function bookAppointment(address _psychologist, string memory _dateTime, string memory _location) public onlyRegisteredPatient(msg.sender) onlyRegisteredPsychologist(_psychologist) {
        Appointment memory newAppointment = Appointment({
            id: appointments[msg.sender].length,
            patient: msg.sender,
            psychologist: _psychologist,
            dateTime: _dateTime,
            location: _location
        });
        appointments[msg.sender].push(newAppointment);

        emit AppointmentBooked(newAppointment.id, newAppointment.patient, newAppointment.psychologist, newAppointment.dateTime, newAppointment.location);
    }

    function getAppointments(uint256 _i) public view returns (Appointment memory) {
        return appointments[msg.sender][_i];
    }

    function getAllAppointments(address _patient) public view returns (Appointment[] memory) {
        return appointments[_patient];
    }
}

// Modify PatientProfile.sol and PsychologistProfile.sol accordingly with similar changes.
