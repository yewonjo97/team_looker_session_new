view: bm_f_card_subway_dd {
  sql_table_name: `project_a_team.bm_f_card_subway_dd`
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

  dimension: station_nm {
    type: string
    sql: ${TABLE}.station_nm ;;
  }

  dimension: subway_line_nm {
    type: string
    sql: ${TABLE}.subway_line_nm ;;
  }

  measure: dynamic_filter_value{
    type: max
    sql: 1 ;;
    html: <p style =
              "color: #000000;
              font-size:70%;
              text-align:left">
              기간 :{{ p_choose_date._parameter_value }}
              &nbsp;&nbsp;&nbsp;
              호선 : {% if _filters['subway_line_nm']%}
                          {{_filters['subway_line_nm']}}
                          {% else %} 전체 {% endif %}
              &nbsp;&nbsp;&nbsp;
              역 : {% if _filters['station_nm']%}
                          {{_filters['station_nm']}}
                          {% else %} 전체 {% endif %}
          </p>;;
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
    sql: ${clean_transported_cnt} / ${bm_f_card_subway_line.line_clean_transported_cnt} ;;
    value_format: "0%"
  }


  parameter: p_choose_date {
    view_label: "Date_Parameter"
    type: date
  }

  dimension: cal_14_days_ago {
    type: date
    sql: DATE_SUB(date({% parameter p_choose_date%}), INTERVAL 14 DAY) ;;
  }

  dimension: period {
    type: string
    sql: case when ${dt_date} >= ${cal_14_days_ago}
              and ${dt_date} <= date({% parameter p_choose_date%}) then "yes"
          else "no" end ;;

  }



}
