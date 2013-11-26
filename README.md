# Timetress

Javascript port of kytrinyx's 'timetress' Ruby Gem

## Installation

```
npm install timetress
```

## Usage / example

You must implement your own national holidays as a subclass of Timetress. See TimetressNorway for an example.

Here are some examples for the implementation for TimtressNorway:

### Find out when the next named holiday is:

```
TimetressNorway.fathersday(2014)
TimetressNorway.nextHoliday('fathersday')
TimetressNorway.nextHoliday('fathersday', new Date(2013, 7, 1))
```

### Find the next workday two days after a date
```
  TimetressNorway.nthWorkdayAfter(2, new Date(2013, 10, 8))
```

## Run tests
```
  cake test
```

## License

Copyright (C) Bengler AS

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
