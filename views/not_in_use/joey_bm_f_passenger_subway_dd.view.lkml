view: joey_bm_f_passenger_subway_dd {
  sql_table_name: `project_a_team.joey_bm_f_passenger_subway_dd`
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


  dimension: rush_hours {
    type: string
    sql: case when ${tm_range_cd} in ('07','08') then '출근시간(07~09)'
        when ${tm_range_cd} in ('18','19') then '퇴근시간(18~20)'
        else '보통시간' END;;
  }


  measure: dynamic_filter_value{
    type: max
    sql: 1 ;;
    html: <p style =
              "color: #412399;
              font-size:50%;
              text-align:left">
              기간 : {% if _filters['dt_date']%}
                          {{ joey_bm_f_passenger_subway_dd.min_date._value }}
                          {{ joey_bm_f_passenger_subway_dd.max_date._value }}
                          {% else %} 전체 {% endif %}
              &nbsp;&nbsp;&nbsp;
              여객 유형 : {% if _filters['bm_d_passenger_type_cd.passenger_type_nm']%}
                          {{_filters['bm_d_passenger_type_cd.passenger_type_nm']}}
                          {% else %} 전체 {% endif %}
              &nbsp;&nbsp;&nbsp;
              호선 : {% if _filters['subway_line_cd']%}
                          {{_filters['subway_line_cd']}}
                          {% else %} 전체 {% endif %}
          </p>;;
  }




  measure: foot_traffic_cnt {
    label: "유동 인원수"
    type: sum
    sql: ${TABLE}.foot_traffic_cnt ;;
  }

  measure: getoff_passenger_cnt {
    label: "하차 인원수"
    type: sum
    sql: ${TABLE}.getoff_passenger_cnt ;;
  }

  measure: passenger_cnt {
    label: "승차 인원수"
    type: sum
    sql: ${TABLE}.passenger_cnt ;;
  }

  measure: clean_transported_cnt {
    label: "순수송인원수"
    type: sum
    sql: ${TABLE}.clean_transported_cnt ;;
  }

  dimension: min_date {
    type: date
    sql: min(${dt_date}) ;;
  }

  dimension: max_date {
    type: date
    sql: max(${dt_date}) ;;
  }
}
