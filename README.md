<!-- [![Build Status](https://travis-ci.org/cpsoinos/hire_away.svg?branch=master)](https://travis-ci.org/cpsoinos/hire_away) -->
  [![Code Climate](https://codeclimate.com/github/cpsoinos/hire_away.png)](https://codeclimate.com/github/cpsoinos/hire_away)

<!-- [![Coverage Status](https://coveralls.io/repos/cpsoinos/hire_away/badge.svg)](https://coveralls.io/r/cpsoinos/hire_away) -->

HireAway
========

HireAway is a project management platform centrered around the user experience.
It utilizes forms toggled by JavaScript and submitted with Ajax to read from
and write to the database in real time, seldom requiring the user to refresh
the page. The main functionality is focused on a user with admin rights and a
Gmail account.

As an admin, you can schedule events and automatically post them to a shared
Google calendar. An event requires a venue, which can be chosen from a list of
existing venues or created on the same page as the event. Once created, the
admin can send out "calls", or job offers, for positions that need to be filled
at said event. Selected users receive these offers by email and can follow a
link to respond with their availability for each call.

####Upcoming features:

- Timecards allowing users to clock-in and clock-out for each event they
participate in. This data will be exportable by an admin for payroll purposes.
- Allowing an admin to input new vendor data
- Displaying proper dress code for each position at each event
- Improved integration with Google Calendars
- Improved notifications on call confirmation
