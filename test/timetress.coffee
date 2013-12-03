expect = require("expect.js")
should = require("should")

Timetress = require("../lib/timetress")
TimetressNorway = require("../lib/norway")

describe "Timetress", ->

  it "should have some constants defined", ->
    Timetress::JANUARY.should.equal 0
    Timetress::DECEMBER.should.equal 11

  describe "Special dates", ->

    it "computes new year day", ->
      Timetress.newYearsDay(2013).toString().should.equal new Date(Date.UTC(2013, 0, 1)).toString()
    it "computes valentines day", ->
      Timetress.valentinesDay(2010).toString().should.equal new Date(Date.UTC(2010, 1, 14)).toString()
    it "computes easter sunday", ->
      Timetress.easterSunday(2013).toString().should.equal new Date(Date.UTC(2013, 2, 31)).toString()
    it "computes maundy thursday", ->
      Timetress.maundyThursday(2013).toString().should.equal new Date(Date.UTC(2013, 2, 28)).toString()
    it "computes good friday", ->
      Timetress.goodFriday(2013).toString().should.equal new Date(Date.UTC(2013, 2, 29)).toString()
    it "computes easter monday", ->
      Timetress.easterMonday(2013).toString().should.equal new Date(Date.UTC(2013, 3, 1)).toString()
    it "computes ascension", ->
      Timetress.ascension(2013).toString().should.equal new Date(Date.UTC(2013, 4, 9)).toString()
    it "computes pentecost sunday", ->
      Timetress.pentecostSunday(2013).toString().should.equal new Date(Date.UTC(2013, 4, 19)).toString()
    it "computes pentecost monday", ->
      Timetress.pentecostMonday(2013).toString().should.equal new Date(Date.UTC(2013, 4, 20)).toString()
    it "computes christmas eve", ->
      Timetress.christmasEve(2013).toString().should.equal new Date(Date.UTC(2013, 11, 24)).toString()
    it "computes christmas", ->
      Timetress.christmas(2013).toString().should.equal new Date(Date.UTC(2013, 11, 25)).toString()
    it "computes boxing day", ->
      Timetress.boxingDay(2013).toString().should.equal new Date(Date.UTC(2013, 11, 26)).toString()
    it "computes new years eve", ->
      Timetress.newYearsEve(2013).toString().should.equal new Date(Date.UTC(2013, 11, 31)).toString()

  describe "Exceptions for beMoreSpecificError", ->
    it "throws error on methods that should be implemented in a country spesific class", ->
      (-> Timetress.officialHolidays(2013)).should.throw(Timetress::beMoreSpecificError)
      (-> Timetress.mothersDay(2013)).should.throw(Timetress::beMoreSpecificError)
      (-> Timetress.fathersDay(2013)).should.throw(Timetress::beMoreSpecificError)
      (-> Timetress.labourDay(2013)).should.throw(Timetress::beMoreSpecificError)
      (-> Timetress.nationalHoliday(2013)).should.throw(Timetress::beMoreSpecificError)
      (-> Timetress.isWorkday(new Date(Date.UTC(2013, 10, 26)))).should.throw(Timetress::beMoreSpecificError)

  describe "next and previous methods", ->

    it "has next methods", ->
      eve = new Date(Date.UTC( (new Date()).getFullYear() , 11, 24)).toString()
      today = new Date()
      add = 0
      add = 1 if today > eve
      Timetress.nextHoliday('christmasEve').toString().should.equal new Date(Date.UTC(((new Date()).getFullYear()+add), 11, 24)).toString()

    it "implements next methods with given date", ->
      Timetress.nextHoliday('christmasEve', new Date(Date.UTC(2011, 11, 25))).toString().should.equal new Date(Date.UTC(2012, 11, 24)).toString()
      Timetress.nextHoliday('christmasEve', new Date(Date.UTC(2011, 11, 23))).toString().should.equal new Date(Date.UTC(2011, 11, 24)).toString()

    it "implements previous methods", ->
      eve = new Date(Date.UTC( (new Date()).getFullYear() , 11, 24)).toString()
      today = new Date()
      subtract = 1
      subtract = 0 if today > eve
      Timetress.previousHoliday('christmasEve').toString().should.equal new Date(Date.UTC(((new Date()).getFullYear()-subtract), 11, 24)).toString()

    it "implements previous methods with given date", ->
      Timetress.previousHoliday('christmasEve', new Date(Date.UTC(2011, 11, 25))).toString().should.equal new Date(Date.UTC(2011, 11, 24)).toString()
      Timetress.previousHoliday('christmasEve', new Date(Date.UTC(2011, 11, 23))).toString().should.equal new Date(Date.UTC(2010, 11, 24)).toString()

describe "TimetressNorway", ->

  describe "Workday can tell if a day is a day off", ->

    it "trues on holiday", ->
      holiday = new Date(2011, 4, 17)
      TimetressNorway.isDayOff(holiday).should.be.ok

    it "trues on saturday", ->
      saturday = new Date(2013, 10, 23)
      TimetressNorway.isDayOff(saturday).should.be.ok

    it "falses on monday", ->
      monday = new Date(2013, 10, 25)
      TimetressNorway.isDayOff(monday).should.not.be.ok

    it "computes next workday after n", ->
      friday = new Date(Date.UTC(2013, 10, 8))
      wednesday = new Date(Date.UTC(2013, 10, 6))
      saturday = new Date(Date.UTC(2013, 10, 9))
      sunday = new Date(Date.UTC(2013, 10, 10))
      monday = new Date(Date.UTC(2013, 10, 11))

      TimetressNorway.nthWorkdayBefore(2, friday).toString().should.equal wednesday.toString()
      TimetressNorway.nthWorkdayBefore(1, monday).toString().should.equal friday.toString()
      TimetressNorway.nthWorkdayBefore(4, sunday).toString().should.equal wednesday.toString()
      TimetressNorway.nthWorkdayAfter(2, wednesday).toString().should.equal friday.toString()
      TimetressNorway.nthWorkdayAfter(3, wednesday).toString().should.equal monday.toString()
      TimetressNorway.nthWorkdayAfter(1, saturday).toString().should.equal monday.toString()


  it "implements its own special holidays ", ->
    TimetressNorway.mothersDay(2013).toString().should.equal new Date(Date.UTC(2013, 1, 10)).toString()
    TimetressNorway.fathersDay(2013).toString().should.equal new Date(Date.UTC(2013, 10, 10)).toString()
    TimetressNorway.labourDay(2013).toString().should.equal new Date(Date.UTC(2013, 4, 1)).toString()
    TimetressNorway.nationalHoliday(2013).toString().should.equal new Date(Date.UTC(2013, 4, 17)).toString()
    TimetressNorway.firstDayOfChristmas(2013).toString().should.equal new Date(Date.UTC(2013, 11, 25)).toString()
    TimetressNorway.secondDayOfChristmas(2013).toString().should.equal new Date(Date.UTC(2013, 11, 26)).toString()

  it "returns a list of official holidays for 2013", ->
    TimetressNorway.officialHolidays(2013).map((date) -> date.toUTCString()).should.eql [
      'Tue, 01 Jan 2013 00:00:00 GMT',
      'Thu, 28 Mar 2013 00:00:00 GMT',
      'Fri, 29 Mar 2013 00:00:00 GMT',
      'Sun, 31 Mar 2013 00:00:00 GMT',
      'Mon, 01 Apr 2013 00:00:00 GMT',
      'Wed, 01 May 2013 00:00:00 GMT',
      'Thu, 09 May 2013 00:00:00 GMT',
      'Fri, 17 May 2013 00:00:00 GMT',
      'Sun, 19 May 2013 00:00:00 GMT',
      'Mon, 20 May 2013 00:00:00 GMT',
      'Wed, 25 Dec 2013 00:00:00 GMT',
      'Thu, 26 Dec 2013 00:00:00 GMT'
    ]
  it "implement next and previous on special class holidays", ->
    TimetressNorway.previousHoliday('fathersDay', new Date(Date.UTC(2011, 11, 25))).toString().should.equal new Date(Date.UTC(2011, 10, 13)).toString()
    TimetressNorway.nextHoliday('fathersDay', new Date(Date.UTC(2011, 11, 25))).toString().should.equal new Date(Date.UTC(2012, 10, 11)).toString()
    TimetressNorway.nextHoliday('firstDayOfChristmas', new Date(Date.UTC(2011, 11, 25))).toString().should.equal new Date(Date.UTC(2011, 11, 25)).toString()
