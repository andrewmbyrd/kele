#Kele
This gem allows you to interface with the Bloc API in order to get user info, mentor availability, etc. The point of this gem is to allow you to do things from the command line (or other applications) that you would otherwise have to do from Bloc's website. The full list of available options is below.

##Available Actions
- [Initialize](#initialize)
- [Get Current User](#get_me)
- [Get Mentor Availability](#mentor)
- [Get Messages](#show-message)
- [Create Messages](#make-message)
- [Create Submissions](#submit)
- [Update Submissions](#update)

##Configuration
As with all other gems, you can place this line of code in your Gemfile

```
gem 'kele'
```
Note, the latest version is 0.0.1 at time of writing.

Alternatively, if you are only using a command line interface, clone this repository into your desired local directory, navigate into the directory from the command line, then go in to the ruby bash
```
irb
```
Then require the gem
```
require 'kele'
```

##Initialize
Desired action to replicate: logging in.
![logging in image](#)

Before you do anything else, you must log in. The desired command here is

```
kele-client = Kele.new(USERNAME, PASSWORD)
```

USERNAME and PASSWORD must be valid log in credentials for the actual Bloc website. If the credentials are not valid, an `ArgumentError` will be raised. Valid credentials will result in a return value of an `@auth_token`, which you will need to validate the rest of the actions for your session. The `@auth_token` should be several dozen alphanumeric characters, along with a couple dots and some dashes.




*
so you can get the mentor_id "automatically" by doing get_me["current_enrollment"]["mentor_id"]
