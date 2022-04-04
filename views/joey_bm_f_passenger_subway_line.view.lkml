view: joey_bm_f_passenger_subway_line {
  sql_table_name: `mzcdsc-team-200716.project_a_team.joey_bm_f_passenger_subway_line`
    ;;

  dimension_group: dt {
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
    sql: ${TABLE}.dt ;;
  }


  dimension: subway_line_cd {
    type: string
    sql: ${TABLE}.subway_line_cd ;;
  }


  measure: line_clean_transported_cnt {
    label: "호선별 순수송인원"
    type: number
    sql: ${TABLE}.clean_transported_cnt ;;
  }

  # measure: line_foot_traffic_cnt {
  #   label: "호선별 유동인원"
  #   type: number
  #   sql: sum(${TABLE}.foot_traffic_cnt) ;;
  # }

  # measure: line_getoff_passenger_cnt {
  #   label: "호선별 하차인원"
  #   type: number
  #   sql: sum(${TABLE}.getoff_passenger_cnt) ;;
  # }

  # measure: line_passenger_cnt {
  #   label: "호선별 승차인원"
  #   type: number
  #   sql: sum(${TABLE}.passenger_cnt) ;;
  # }

}
