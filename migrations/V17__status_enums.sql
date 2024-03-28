CREATE TYPE t_service_status AS ENUM ('AVAILABLE', 'UNAVAILABLE');
CREATE TYPE t_profile_status AS ENUM ('COMPLETE', 'INCOMPLETE');
CREATE TYPE t_medical_status AS ENUM ('UNKNOWN', 'PERMANENTLY_INELIGIBLE', 'TEMPORARILY_INELIGIBLE', 'ELIGIBLE');
CREATE TYPE t_participation_status AS ENUM('OPTED_OUT', 'PAUSED', 'PARTICIPATING');
