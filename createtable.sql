CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,    -- Auto-incremented primary key
    first_name VARCHAR(50) NOT NULL,   -- First name with a maximum of 50 characters
    last_name VARCHAR(50) NOT NULL,    -- Last name with a maximum of 50 characters
    email VARCHAR(100) UNIQUE NOT NULL -- Unique email address
);
