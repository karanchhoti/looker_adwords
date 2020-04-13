view: google_play_installs {
  derived_table: {
    sql: SELECT date, Country, sum(Active_Device_Installs) as active_device_installs, sum(Daily_Device_Installs) as daily_device_installs, sum(Daily_Device_Uninstalls) as daily_device_uninstalls
      FROM looker_google_play.Installs_country_bq_
      where Package_Name = 'com.splash.kids.education.learning.games.free.multiplication.reading.math.grade.app.splashmath'
      group by 1,2
       ;;
  }


  dimension_group: date {
    type: time
    sql: TIMESTAMP(${TABLE}.date) ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.Country ;;
  }

  measure: active_device_installs {
    type: sum
    sql: ${TABLE}.active_device_installs ;;
  }

  measure: daily_device_installs {
    type: sum
    sql: ${TABLE}.daily_device_installs ;;
  }

  measure: daily_device_uninstalls {
    type: sum
    sql: ${TABLE}.daily_device_uninstalls ;;
  }

}
