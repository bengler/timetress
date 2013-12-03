Timetress = require "./timetress"

class TimetressNorway extends Timetress

  @mothersday:  (year) ->
    @secondSundayIn(@::FEBRUARY, year)

  @fathersday: (year) ->
    @secondSundayIn(@::NOVEMBER, year)

  @labourDay: (year) ->
    new Date(Date.UTC(year, @::MAY, 1))

  @nationalHoliday: (year) ->
    new Date(Date.UTC(year, @::MAY, 17))

  @christmas: (year) ->
    throw new Error("Do you mean `christmasEve` or `firstDayOfChristmas`?")

  @firstDayOfChristmas: (year) ->
    new Date(Date.UTC(year, @::DECEMBER, 25))

  @secondDayOfChristmas: (year) ->
    @boxingDay(year)

  @officialHolidays: (year) ->
    [
      @newYearsDay(year),
      @maundyThursday(year),
      @goodFriday(year),
      @easterSunday(year),
      @easterMonday(year),
      @labourDay(year),
      @nationalHoliday(year),
      @ascension(year),
      @pentecostSunday(year),
      @pentecostMonday(year),
      @firstDayOfChristmas(year),
      @boxingDay(year),
    ].sort(@sortDates)

  @publicHolidays: (year) ->
    @officialHolidays(year)

  @legalHolidays: (year) ->
    @officialHolidays(year)

module.exports = TimetressNorway
