$('.form-subscribe input[type="text"], .form-subscribe input[type="email"]').live('focus keypress', function() {
		var $email = $(this);
		
		if ($email.hasClass('error')) {
			$email.val('').removeClass('error');
		}
		if ($email.hasClass('success')) {
			$email.val('').removeClass('success');
		}
	});
	
	// Subscribe form when submit to database
	$('.form-subscribe').submit(function() {
		var $email	= $(this).find('input[name="email"]');
		var $submit	= $(this).find('input[name="submit"]');
		
		var email_pattern = /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$/i;
		if (email_pattern.test($email.val()) === false) {
			$email.val('Please enter a valid email address!').addClass('error');
		} else {
			var submitData = $(this).serialize();
			$email.attr('disabled','disabled');
			$submit.attr('disabled','disabled');
			$.ajax({ // Subcribe process with AJAX
				type: 'POST',
				url: './assets/mailchimp/process-subscribe.php',
				data: submitData + '&action=add',
				dataType: 'html',
				success: function(msg) {
					if (parseInt(msg, 0) !== 0) {
						var msg_split = msg.split('|');
						
						if (msg_split[0] === 'success') {
							$submit.removeAttr('disabled');
							$email.removeAttr('disabled').val(msg_split[1]).addClass('success');
						} else {
							$submit.removeAttr('disabled');
							$email.removeAttr('disabled').val(msg_split[1]).addClass('error');
						}
					}
				}
			});
		}
		
		return false;
	});
	
