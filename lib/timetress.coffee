easterDates = [ "1900-04-15", "1901-04-07", "1902-03-30", "1903-04-12", "1904-04-03", "1905-04-23", "1906-04-15", "1907-03-31", "1908-04-19", "1909-04-11", "1910-03-27", "1911-04-16", "1912-04-07", "1913-03-23", "1914-04-12", "1915-04-04", "1916-04-23", "1917-04-08", "1918-03-31", "1919-04-20", "1920-04-04", "1921-03-27", "1922-04-16", "1923-04-01", "1924-04-20", "1925-04-12", "1926-04-04", "1927-04-17", "1928-04-08", "1929-03-31", "1930-04-20", "1931-04-05", "1932-03-27", "1933-04-16", "1934-04-01", "1935-04-21", "1936-04-12", "1937-03-28", "1938-04-17", "1939-04-09", "1940-03-24", "1941-04-13", "1942-04-05", "1943-04-25", "1944-04-09", "1945-04-01", "1946-04-21", "1947-04-06", "1948-03-28", "1949-04-17", "1950-04-09", "1951-03-25", "1952-04-13", "1953-04-05", "1954-04-18", "1955-04-10", "1956-04-01", "1957-04-21", "1958-04-06", "1959-03-29", "1960-04-17", "1961-04-02", "1962-04-22", "1963-04-14", "1964-03-29", "1965-04-18", "1966-04-10", "1967-03-26", "1968-04-14", "1969-04-06", "1970-03-29", "1971-04-11", "1972-04-02", "1973-04-22", "1974-04-14", "1975-03-30", "1976-04-18", "1977-04-10", "1978-03-26", "1979-04-15", "1980-04-06", "1981-04-19", "1982-04-11", "1983-04-03", "1984-04-22", "1985-04-07", "1986-03-30", "1987-04-19", "1988-04-03", "1989-03-26", "1990-04-15", "1991-03-31", "1992-04-19", "1993-04-11", "1994-04-03", "1995-04-16", "1996-04-07", "1997-03-30", "1998-04-12", "1999-04-04", "2000-04-23", "2001-04-15", "2002-03-31", "2003-04-20", "2004-04-11", "2005-03-27", "2006-04-16", "2007-04-08", "2008-03-23", "2009-04-12", "2010-04-04", "2011-04-24", "2012-04-08", "2013-03-31", "2014-04-20", "2015-04-05", "2016-03-27", "2017-04-16", "2018-04-01", "2019-04-21", "2020-04-12", "2021-04-04", "2022-04-17", "2023-04-09", "2024-03-31", "2025-04-20", "2026-04-05", "2027-03-28", "2028-04-16", "2029-04-01", "2030-04-21", "2031-04-13", "2032-03-28", "2033-04-17", "2034-04-09", "2035-03-25", "2036-04-13", "2037-04-05", "2038-04-25", "2039-04-10", "2040-04-01", "2041-04-21", "2042-04-06", "2043-03-29", "2044-04-17", "2045-04-09", "2046-03-25", "2047-04-14", "2048-04-05", "2049-04-18", "2050-04-10", "2051-04-02", "2052-04-21", "2053-04-06", "2054-03-29", "2055-04-18", "2056-04-02", "2057-04-22", "2058-04-14", "2059-03-30", "2060-04-18", "2061-04-10", "2062-03-26", "2063-04-15", "2064-04-06", "2065-03-29", "2066-04-11", "2067-04-03", "2068-04-22", "2069-04-14", "2070-03-30", "2071-04-19", "2072-04-10", "2073-03-26", "2074-04-15", "2075-04-07", "2076-04-19", "2077-04-11", "2078-04-03", "2079-04-23", "2080-04-07", "2081-03-30", "2082-04-19", "2083-04-04", "2084-03-26", "2085-04-15", "2086-03-31", "2087-04-20", "2088-04-11", "2089-04-03", "2090-04-16", "2091-04-08", "2092-03-30", "2093-04-12", "2094-04-04", "2095-04-24", "2096-04-15", "2097-03-31", "2098-04-20", "2099-04-12" ]
easterHash = {}
for date in easterDates
  parts = date.split("-")
  easterDate = Date.UTC(Number(parts[0]), Number(parts[1])-1, Number(parts[2]))
  easterHash[Number(parts[0])] = easterDate

class Timetress
  JANUARY: 0
  FEBRUARY: 1
  MAY: 4
  NOVEMBER: 10
  DECEMBER: 11

  EASTER: easterHash

  beMoreSpecificError: new Error "Different in different countries. Try a country-specific subclass."

  @isDayOff: (date) ->
    utc = Date.UTC(date.getFullYear(), date.getMonth(), date.getDate())
    [0,6].indexOf(date.getDay()) > -1 or
      @officialHolidays(date.getFullYear()).map((date) -> date.toString()).indexOf(new Date(utc).toString()) > -1

  @isWorkday: (date) ->
    !@isDayOff(date)

  @nthWorkdayAfter: (n, date) ->
    utc = Date.UTC(date.getUTCFullYear(), date.getUTCMonth(), date.getUTCDate())
    target = utc + (n * 86400000)
    until @isWorkday(new Date(target))
     target += 86400000
    new Date(target)

  @nthWorkdayBefore: (n, date) ->
    utc = Date.UTC(date.getUTCFullYear(), date.getUTCMonth(), date.getUTCDate())
    target = utc - (n * 86400000)
    until @isWorkday(new Date(target))
      target -= 86400000
    new Date(target)

  @newYearsDay: (year) ->
    new Date(Date.UTC(year, @::JANUARY, 1))

  @valentinesDay: (year) ->
    new Date(Date.UTC(year, @::FEBRUARY, 14))

  @easterSunday: (year) ->
    new Date(@::EASTER[year])

  @maundyThursday: (year) ->
    sun = @.easterSunday(year)
    sun.setUTCDate(sun.getUTCDate()-3)
    sun

  @goodFriday: (year) ->
    sun = @.easterSunday(year)
    sun.setUTCDate(sun.getUTCDate()-2)
    sun

  @easterMonday: (year) ->
    sun = @.easterSunday(year)
    sun.setUTCDate(sun.getUTCDate()+1)
    sun

  @ascension: (year) ->
    sun = @.easterSunday(year)
    sun.setUTCDate(sun.getUTCDate()+39)
    sun

  @pentecostSunday: (year) ->
    sun = @.easterSunday(year)
    sun.setUTCDate(sun.getUTCDate()+49)
    sun

  @pentecostMonday: (year) ->
    sun = @.easterSunday(year)
    sun.setUTCDate(sun.getUTCDate()+50)
    sun

  @christmasEve: (year) ->
    new Date(Date.UTC(year, @::DECEMBER, 24))

  @christmas: (year) ->
    new Date(Date.UTC(year, @::DECEMBER, 25))

  @boxingDay: (year) ->
    new Date(Date.UTC(year, @::DECEMBER, 26))

  @newYearsEve: (year) ->
    new Date(Date.UTC(year, @::DECEMBER, 31))

  @officialHolidays: (year) ->
    throw @::beMoreSpecificError

  @mothersDay: (year) ->
    throw @::beMoreSpecificError

  @fathersDay: (year) ->
    throw @::beMoreSpecificError

  @labourDay: (year) ->
    throw @::beMoreSpecificError

  @nationalHoliday: (year) ->
    throw @::beMoreSpecificError

  @nextHoliday: (holiday, givenDate) ->
    unless givenDate
      today = new Date()
      givenDate = new Date(today.getUTCFullYear(), today.getUTCMonth(), today.getUTCDate())

    throw new Error("givenDate must be a Date object") unless givenDate instanceof Date
    givenDate.setUTCHours(0)
    givenDate.setUTCMinutes(0)
    givenDate.setUTCSeconds(0)

    theDay = @[holiday](givenDate.getUTCFullYear())
    if givenDate.getTime() > theDay.getTime()
      theDay = @[holiday](givenDate.getUTCFullYear() + 1)
    theDay

  @previousHoliday: (holiday, givenDate) ->
    unless givenDate
      today = new Date()
      givenDate = new Date(today.getUTCFullYear(), today.getUTCMonth(), today.getUTCDate())

    throw new Error("givenDate must be a Date object") unless givenDate instanceof Date
    givenDate.setUTCHours(0)
    givenDate.setUTCMinutes(0)
    givenDate.setUTCSeconds(0)

    theDay = @[holiday](givenDate.getUTCFullYear())
    if theDay.getTime() >= givenDate.getTime()
      theDay = @[holiday](givenDate.getUTCFullYear() - 1)
    theDay

  @sortDates: (date1, date2) ->
    return 1 if (date1 > date2)
    return -1 if (date1 < date2)
    return 0

  @daysUntilSunday: (date) ->
    (7 - date.getUTCDay()) % 7

  @secondSundayIn: (month, year) ->
    secondWeek = Date.UTC(year, month, 8)
    new Date(secondWeek + (86400000 * @daysUntilSunday(new Date(secondWeek))))

module.exports = Timetress
