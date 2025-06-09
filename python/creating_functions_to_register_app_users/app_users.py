"""
Create a validate_user() function, using some helper validation functions to verify user input.

The function should take in the parameters: name, email, and password.
The function should call each of the helper validation functions (validate_name(), validate_email(), and validate_password()).
If any check fails, raise a ValueError with a descriptive error message about the failing validation.
If all checks pass, return True.
Now that you've validated that all the user details are correct, you want to allow users to register to the app. Create a register_user() function to handle the registration logic.

The function should take in the parameters: name, email, and password.
Inside, it should call validate_user() to ensure that the user input is valid.
If validate_user() raises a ValueError, register_user() should catch the exception and return False.
Otherwise, it should create and return a dictionary with the keys: name, email, and password.



Requirement
-Create function called validate_user()
    -takes 3 parameters, name, email and password
    -needs to call python_functions functions validate_name(), validate_email(), and validate_password()
    -Needs ValueError for functions that fail
    -Return true if all checks pass 
-Create function called register_user() when all checks are passed
    -takes three parameters, name, email and password 
    -calls validate_user to pass checks
    -returns false if validate_user raisers valueerror 
    -create and return dictionary with keys name, email, password if validate_user returns true


"""

# Re-run this cell and examine the docstring of each function
from python_functions import validate_name, validate_email, validate_password, top_level_domains

def validate_user(name, email, password):
    if not validate_name(name):
        raise ValueError("not a string or the character length is less than 2")
        
    if not validate_email(email):
        raise ValueError("no @ symbol, length is less than 1 and uses a top level domain")

    if not validate_password(password):
        raise ValueError("password is less than 8 characters, has no digits between 0-9 or capital letters between a to z")
    
    return True 


def register_user(name, email, password):
    try:
        validate_user(name, email, password)
    except ValueError:
        return False 
    return{
        "name": name,
        "email": email,
        "password": password
    }
