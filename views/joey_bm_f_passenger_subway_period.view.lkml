view: joey_bm_f_passenger_subway_period {
  sql_table_name: `mzcdsc-team-200716.project_a_team.joey_bm_f_passenger_subway_period`
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

  dimension: passenger_type_cd {
    type: string
    sql: ${TABLE}.passenger_type_cd ;;
  }

  dimension: station_cd {
    type: string
    sql: ${TABLE}.station_cd ;;
  }

  dimension: subway_line_cd {
    type: string
    sql: ${TABLE}.subway_line_cd ;;
  }

  dimension: tm_range_cd {
    type: string
    sql: ${TABLE}.tm_range_cd ;;
  }

  dimension: gubun {
    type: string
    sql: ${TABLE}.gubun ;;
  }


  measure: now_cnt {
    type: sum
    sql: ${TABLE}.cnt ;;
  }

  measure: prev_cnt {
    type: number
    sql: ${joey_bm_f_passenger_subway_previous.cnt} ;;
  }


  # measure: now_line_clean {
  #   type :  number
  #   sql: max(${joey_bm_f_passenger_subway_line.line_clean_transported_cnt}) ;;
  # }

  # measure: prev_line_clean {
  #   type :  number
  #   sql: max(${joey_bm_f_passenger_subway_line_previous.line_clean_transported_cnt}) ;;
  # }


  # measure: now_rate {
  #   type: number
  #   sql: ${now_cnt}/${now_line_clean} ;;
  # }

  # measure: prev_rate {
  #   type: number
  #   sql: ${prev_cnt}/${prev_line_clean} ;;
  # }


  measure : diff {
    type: number
    sql:  ${now_cnt}-${prev_cnt} ;;
  }


  parameter: p_date_from {
    view_label: "Date_Parameter"
    type: date
  }

  parameter: p_date_to {
    view_label: "Date_Parameter"
    type: date
  }


  dimension: period {
    type: string
    sql: case when ${dt_date} >= date({% parameter p_date_from%})
                    and ${dt_date} <= date({% parameter p_date_to%}) then "당기"
              when ${dt_date} >= date_sub(date({% parameter p_date_from%}), interval 1 month)
                    and ${dt_date} <= date_sub(date({% parameter p_date_to%}), interval 1 month) then "전기"
        end ;;
  }

}
