// Generated by CoffeeScript 1.6.3
(function() {
  var Timetress, TimetressNorway, _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Timetress = require("./timetress");

  TimetressNorway = (function(_super) {
    __extends(TimetressNorway, _super);

    function TimetressNorway() {
      _ref = TimetressNorway.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    TimetressNorway.mothersDay = function(year) {
      return this.secondSundayIn(this.prototype.FEBRUARY, year);
    };

    TimetressNorway.fathersDay = function(year) {
      return this.secondSundayIn(this.prototype.NOVEMBER, year);
    };

    TimetressNorway.labourDay = function(year) {
      return new Date(Date.UTC(year, this.prototype.MAY, 1));
    };

    TimetressNorway.nationalHoliday = function(year) {
      return new Date(Date.UTC(year, this.prototype.MAY, 17));
    };

    TimetressNorway.christmas = function(year) {
      throw new Error("Do you mean `christmasEve` or `firstDayOfChristmas`?");
    };

    TimetressNorway.firstDayOfChristmas = function(year) {
      return new Date(Date.UTC(year, this.prototype.DECEMBER, 25));
    };

    TimetressNorway.secondDayOfChristmas = function(year) {
      return this.boxingDay(year);
    };

    TimetressNorway.officialHolidays = function(year) {
      return [this.newYearsDay(year), this.maundyThursday(year), this.goodFriday(year), this.easterSunday(year), this.easterMonday(year), this.labourDay(year), this.nationalHoliday(year), this.ascension(year), this.pentecostSunday(year), this.pentecostMonday(year), this.firstDayOfChristmas(year), this.boxingDay(year)].sort(this.sortDates);
    };

    TimetressNorway.publicHolidays = function(year) {
      return this.officialHolidays(year);
    };

    TimetressNorway.legalHolidays = function(year) {
      return this.officialHolidays(year);
    };

    return TimetressNorway;

  })(Timetress);

  module.exports = TimetressNorway;

}).call(this);