view: joey_bm_f_passenger_subway_previous {
  derived_table: {
    sql:
      select date_add(dt, interval 1 month ) as next_dt
            , dt as previous_dt
            , tm_range_cd
            , subway_line_cd
            , station_cd
            , passenger_type_cd
            , gubun
            , cnt
      from `project_a_team.joey_bm_f_passenger_subway_period`
      ;;
  }


  dimension_group: next_dt {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.next_dt ;;
  }

  dimension_group: previous_dt {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.previous_dt ;;
  }


  dimension: passenger_type_cd {
    hidden: yes
    type: string
    sql: ${TABLE}.passenger_type_cd ;;
  }

  dimension: station_cd {
    hidden: yes
    type: string
    sql: ${TABLE}.station_cd ;;
  }

  dimension: subway_line_cd {
    hidden: yes
    type: string
    sql: ${TABLE}.subway_line_cd ;;
  }

  dimension: tm_range_cd {
    hidden: yes
    type: string
    sql: ${TABLE}.tm_range_cd ;;
  }

  dimension: gubun {
    hidden: yes
    type: string
    sql: ${TABLE}.gubun ;;
  }

  measure: cnt {
    label: "previous_cnt"
    type: number
    sql: sum(${TABLE}.cnt) ;;
  }


}
