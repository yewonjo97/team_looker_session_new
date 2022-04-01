view: bm_f_passenger_subway_dd {
  sql_table_name: `project_a_team.bm_f_passenger_subway_dd`
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

  measure: clean_transported_cnt {
    label: "순수송인원"
    type: sum
    sql: ${TABLE}.clean_transported_cnt ;;
  }

  measure: foot_traffic_cnt {
    label: "유동인원"
    type: sum
    sql: ${TABLE}.foot_traffic_cnt ;;
  }

  measure: getoff_passenger_cnt {
    label: "하차인원"
    type: sum
    sql: ${TABLE}.getoff_passenger_cnt ;;
  }

  measure: passenger_cnt {
    label: "승차인원"
    type: sum
    sql: ${TABLE}.passenger_cnt ;;
  }

  measure: passenger_rate {
    label: "수송분담율"
    type: number
    sql: ${clean_transported_cnt} / ${bm_f_passenger_subway_line.line_clean_transported_cnt} ;;
    value_format: "0%"
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

  measure: now_passenger_cnt {
    label: "당기승차인원"
    type: number
    sql: case when ${period} = '당기' then ${passenger_cnt} else 0 end ;;
  }

  measure: old_passenger_cnt {
    label: "전기승차인원"
    type: number
    sql: case when ${period} = '전기' then ${passenger_cnt} else 0 end ;;
  }

}
