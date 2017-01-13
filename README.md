#Kele
This gem allows you to interface with the Bloc API in order to get user info, mentor availability, etc. The point of this gem is to allow you to do things from the command line (or other applications) that you would otherwise have to do from Bloc's website. The full list of available options is below.

##Available Actions
- [Initialize](#initialize)
- [Get Current User](#get_me)
- [Get Mentor Availability](#mentor-availability)
- [Get Roadmap](#get_roadmap)
- [Get Checkpoint](#get_checkpoint)
- [Get Messages](#show-message)
- [Create Messages](#create-message)
- [Create Submissions](#create_submissionsubmit)
- [Update Submissions](#update_submission)

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
![logging in image](http://imgur.com/4Nvn6Hr.png)

Before you do anything else, you must log in. The desired command here is

```
kele-client = Kele.new(USERNAME, PASSWORD)
```

USERNAME and PASSWORD must be valid log in credentials for the actual Bloc website. If the credentials are not valid, an `ArgumentError` will be raised. Valid credentials will result in a return value of an `@auth_token`, which you will need to validate the rest of the actions for your session. The `@auth_token` should be several dozen alphanumeric characters, along with a couple dots and some dashes.

##get_me
Desired action to replicate: obtaining all information from the user profile.
![Profile Page](http://imgur.com/YyBIBa2.png)

This function will use the `@auth_token` that was generated on initialization. No arguments need to be passed into the function call

```bash
kele-client.get_me
```

What is returned is a hash containing user first name, last name, enrollment id, etc. This information is stored in `@current_user_hash`, which contains necessary information for other function calls.

##Mentor Availability
Desired action to replicate: establishing a schedule for call-ins with a mentor.

![mentor schedule](http://imgur.com/5yHU2kZ.png)

This function allows you to view the appointment schedule of any mentor whose mentor id you know. You can call the function with or without a mentor id.

```
kele-client.get_mentor_availability
```

OR
```
kele-client.get_mentor_availability(mentor_id)
```

If you don't pass in a mentor_id, then Kele will pull it from your `@current_user_hash`, even if you haven't directly retrieved it with the call to `get_me`.

The function returns an array of mentor schedule times.


##Get Roadmap
Desired action to replicate: viewing a course road map.
![roadmap](http://imgur.com/QYkjK5v.png)

Note: this function is in `roadmap.rb`, which is required in `kele.rb`.

You can pass in a `roadmap_id` to show data for that roadmap.

```
kele-client.get_roadmap(roadmap_id)
```
This returns a hash containing details of the checkpoints in the roadmap.

##Get Checkpoint
Desired action to replicate: viewing a checkpoint.

![checkpoint](http://imgur.com/t5l9S4N.png)

Note: this function is in `roadmap.rb`, which is required in `kele.rb`.

Now that you know a few checkpoint ids from having run your `get_roadmap` function, you can use them to view a checkcpoint.

```bash
kele-client.get_checkpoint(checkpoint_id)
```

You'll get back a hash with checkpoint information such as its name, expected duration, etc.

##Get Messages
Desired action to replicate: showing message threads.


By passing in a page number, you can view the content of each of the message threads on that page. There are 10 message threads per page.

```bash
kele-client.get_messages(2)
```

Alternatively, by not passing in a page number, you'll get details of every message on your profile. Object type returned is a hash.

```bash
kele-client.get_messages
```

##Create Message
Desire action to replicate: creating a new message thread.

![create message](http://imgur.com/6W3A1Y8.png)

This function will create a message in a new message thread from you to a person of your choice. The message will always come from you, but you can to whom you send it.

```bash
kele-client.create_message(subject, body, recipient_id: id_number)
```

_You do not have to provide the third argument_. If you don't, the message wil be sent to your mentor by default.

A string of "Success" will be returned if the message goes through. Otherwise an error string will be returned.

##Create Submission

Desired action to replicate: submitting an assignment.

![submit assignment](http://imgur.com/51msjRh.png)

You can submit an assignment through kele! You call this function like so:

```
kele-client.create_submission(checkpoint_id, assignment_branch, assignment_commit_link, comment)
```
- The checkpoint_id is the id of the checkpoint for which you want to submit an assignment. Among other places, you obtain an id from the ```get_roadmap``` function above.

- `assignment_branch` is the name of the github branch from which you want to pull the files. e.g. `master`

- `assignment_commit_link` is the github URL of your desired commit. It has a format of `https://github.com/user/project_name/commit/commit-id`

- `comment` is optional, but you should put one!
