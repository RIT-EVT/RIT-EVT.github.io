$(document).ready(function () {
                
          
        // validate checkout form on keyup and submit
		$("#checkoutForm").validate({
			rules: {
				fname: "required",
				lname: "required",
				username: {
					required: true,
					minlength: 2
				},
				password: {
					required: true,
					minlength: 5
				},
				confirm_password: {
					required: true,
					minlength: 5,
					equalTo: "#password"
				},
				email: {
					required: true,
					email: true
				},
                                phone: {
					required: true,
					minlength: 10
				},
                                address: {
					required: true
				},
                                country: {
					required: true
					
				},
                                state: {
					required: true
					
				},
                                 zipcode: {
					required: true,
					minlength: 6
				}
                                
			},
			messages: {
				firstname: "Please enter your firstname",
				lastname: "Please enter your lastname",
                                phone: "Numbers Only, Min 10 Digit",
                                country: "Select a country",
                                state: "Select your state",
                                zipcode: "Enter code, Numbers only",
				username: {
					required: "Please enter a username",
					minlength: "Your username must consist of at least 2 characters"
				},
				password: {
					required: "Please provide a password",
					minlength: "Your password must be at least 5 characters long"
				},
				confirm_password: {
					required: "Please provide a password",
					minlength: "Your password must be at least 5 characters long",
					equalTo: "Please enter the same password as above"
				},
				email: "Please enter a valid email address",
				agree: "Please accept our policy"
			}
		});
            });