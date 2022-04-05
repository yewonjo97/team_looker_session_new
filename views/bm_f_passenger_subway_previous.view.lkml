view: bm_f_passenger_subway_previous {
derived_table: {
  sql:
      select date_add(dt, interval 1 month ) as next_dt
            , dt as perivous_dt
            , tm_range_cd
            , subway_line_cd
            , station_cd
            , passenger_type_cd
            , '총 승차 인원수' as gubun
            , passenger_cnt as cnt
      from `project_a_team.bm_f_passenger_subway_dd`
    --   group by dt, tm_range_cd, subway_line_cd, station_cd, passenger_type_cd

      union all

      select date_add(dt, interval 1 month ) as next_dt
            , dt as perivous_dt
            , tm_range_cd
            , subway_line_cd
            , station_cd
            , passenger_type_cd
            , '총 하차 인원수' as gubun
            , getoff_passenger_cnt as  cnt
      from `project_a_team.bm_f_passenger_subway_dd`
    --   group by dt, tm_range_cd, subway_line_cd, station_cd, passenger_type_cd

      union all

      select date_add(dt, interval 1 month ) as next_dt
            , dt as perivous_dt
            , tm_range_cd
            , subway_line_cd
            , station_cd
            , passenger_type_cd
            , '유동 인원수' as gubun
            , foot_traffic_cnt as  cnt
      from `project_a_team.bm_f_passenger_subway_dd`
    --   group by dt, tm_range_cd, subway_line_cd, station_cd, passenger_type_cd

      union all

      select date_add(dt, interval 1 month ) as next_dt
            , dt as perivous_dt
            , tm_range_cd
            , subway_line_cd
            , station_cd
            , passenger_type_cd
            , '순수송 인원수' as gubun
            , clean_transported_cnt as  cnt
      from `project_a_team.bm_f_passenger_subway_dd`
    --   group by dt, tm_range_cd, subway_line_cd, station_cd, passenger_type_cd
      ;;

}



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


dimension: gubun {
  type: string
  sql: ${TABLE}.gubun ;;
}

measure: cnt {
  type: sum
  sql: ${TABLE}.cnt ;;
}

}
