view: android_installs_and_app_crashes {
  derived_table: {
    sql: select crash.date,crash.App_Version_Code, sum(Daily_Device_Installs) as Daily_Device_Installs, sum(Daily_Crashes) as Daily_Crashes, sum(Daily_ANRs) as Daily_ANRs
      from
      (select TIMESTAMP(Date) as date, App_Version_Code, sum(Daily_Crashes) as Daily_Crashes, sum(Daily_ANRs) as Daily_ANRs
      from `big-query-269914.looker_google_play.Crashes_app_version_bq_`
      where Package_Name = 'com.splash.kids.education.learning.games.free.multiplication.reading.math.grade.app.splashmath'
      group by 1,2) as crash
      left join
      (select TIMESTAMP(Date) as date, App_Version_Code, sum(Daily_Device_Installs) as Daily_Device_Installs
      from `big-query-269914.looker_google_play.Installs_app_version_bq_`
      where Package_Name = 'com.splash.kids.education.learning.games.free.multiplication.reading.math.grade.app.splashmath'
      group by 1,2) as install



      on install.date = crash.date and
         install.App_Version_Code = crash.App_Version_Code
         group by 1,2
       ;;
  }

  dimension_group: date {
    type: time
    sql: ${TABLE}.date ;;
  }

  dimension: app_version_code {
    type: number
    sql: ${TABLE}.App_Version_Code ;;
  }

  measure: daily_device_installs {
    type: sum
    sql: ${TABLE}.Daily_Device_Installs ;;
  }

  measure: daily_crashes {
    type: sum
    sql: ${TABLE}.Daily_Crashes ;;
  }

  measure: daily_anrs {
    type: sum
    sql: ${TABLE}.Daily_ANRs ;;
  }

 }
