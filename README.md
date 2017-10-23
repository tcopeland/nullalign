# Nullalign

## Description

nullalign is a tool to detect missing non-null constraints in Rails projects.

Suppose you have a validation like this:

    validates :email, presence: true

Do you have a non-null constraint in your database to back that up?  If not, nullalign will find it for you.

Nullalign is based on Colin Jones' [consistency_fail](https://github.com/trptcolin/consistency_fail).  I mean really really based on it, as in I copied and pasted over a bunch of the code and changed the module and file names.  And a lot of this README, too.

## Installation

Put this in the `development` group in your `Gemfile`

    gem 'nullalign'

## Usage

Run it like this:

    bundle exec nullalign

## Example output

    There are presence validators that aren't backed by non-null constraints.
    --------------------------------------------------------------------------------
    Model              Table Columns
    --------------------------------------------------------------------------------
    Album              albums: name, owner_id
    AttendanceRecord   attendance_records: group_id, attended_at
    CheckinLabel       checkin_labels: name, xml
    CheckinTime        checkin_times: campus

## Limitations

nullalign depends on being able to find all your `ActiveRecord::Base`
subclasses with some `$LOAD_PATH` trickery. If any models are in a path either
not on your project's load path or in a path that doesn't include the word
"models", nullalign won't be able to find or analyze them. I'm open to
making the text "models" configurable if people want that. Please open an issue
or pull request if so!

To disable nullalign, I could add a thing that checks column comments for a string
like 'nonullalign' if people think that would be useful.  Just let me know.

## Contributors

* [Tom Copeland](https://thomasleecopeland.com) - author
* [Woongcheol Yang](https://github.com/woongy) - support for conditional validations

## Tests

You can run the tests with:

    bundle exec rspec

## License

Released under the MIT License. See the LICENSE file for further details.
