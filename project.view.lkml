view: project {
  sql_table_name: kicktarter.project ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: backers_count {
    type: string
    sql: ${TABLE}.backers_count ;;
  }

  dimension: blurb {
    type: string
    sql: ${TABLE}.blurb ;;
  }

  dimension: _category_json {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: category_slug {
    type: string
    sql:  JSON_EXTRACT_SCALAR(${_category_json}, "$.slug") ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension_group: created_at {
    type: time
    timeframes: [date, month, year]
    datatype: epoch
    sql: CAST(${TABLE}.created_at AS INT64) ;;
  }

  dimension: creator {
    type: string
    sql: ${TABLE}.creator ;;
  }

  dimension: currency {
    type: string
    sql: ${TABLE}.currency ;;
  }

  dimension: currency_symbol {
    type: string
    sql: ${TABLE}.currency_symbol ;;
  }

  dimension: currency_trailing_code {
    type: string
    sql: ${TABLE}.currency_trailing_code ;;
  }

  dimension_group: deadline {
    type: time
    timeframes: [date, month, year]
    datatype: epoch
    sql: CAST(${TABLE}.deadline AS INT64) ;;
  }

  dimension: disable_communication {
    type: string
    sql: ${TABLE}.disable_communication ;;
  }

  dimension: friends {
    type: string
    sql: ${TABLE}.friends ;;
  }

  dimension: goal {
    type: number
    value_format: "$#,##0.00"
    sql: CAST(${TABLE}.goal AS FLOAT64) ;;
  }

  dimension: is_backing {
    type: string
    sql: ${TABLE}.is_backing ;;
  }

  dimension: is_starred {
    type: string
    sql: ${TABLE}.is_starred ;;
  }

  dimension_group: launched_at {
    type: time
    timeframes: [date, month, year]
    datatype: epoch
    sql: CAST(${TABLE}.launched_at AS INT64);;
  }

  dimension: location {
    type: string
    sql: ${TABLE}.location ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
    html: <a href="{{ home_url._value }}" target="_blank">{{ value }}</a> ;;
  }

  dimension: permissions {
    type: string
    sql: ${TABLE}.permissions ;;
  }

  dimension: _photo_json {
    type: string
    sql: ${TABLE}.photo ;;
  }

  dimension: thumbnail {
    group_label: "Images"
    type: string
    sql:  JSON_EXTRACT_SCALAR(${_photo_json}, "$.thumb");;
    html: <a href="{{ home_url._value }}" target="_blank"><img src="{{ value }}"/></a> ;;
  }

  dimension: small {
    group_label: "Images"
    type: string
    sql:  JSON_EXTRACT_SCALAR(${_photo_json}, "$.small");;
    html: <a href="{{ home_url._value }}" target="_blank"><img src="{{ value }}"/></a> ;;
  }

  dimension: med {
    group_label: "Images"
    type: string
    sql:  JSON_EXTRACT_SCALAR(${_photo_json}, "$.med");;
    html: <a href="{{ home_url._value }}" target="_blank"><img src="{{ value }}"/></a> ;;
  }

  dimension: full {
    group_label: "Images"
    type: string
    sql:  JSON_EXTRACT_SCALAR(${_photo_json}, "$.full");;
    html: <a href="{{ home_url._value }}" target="_blank"><img src="{{ value }}"/></a> ;;
  }

  dimension: pledged {
    type: number
    value_format: "$#,##0.00"
    sql: CAST(${TABLE}.pledged AS FLOAT64) ;;
  }

  dimension: profile {
    type: string
    sql: ${TABLE}.profile ;;
  }

  dimension: slug {
    type: string
    sql: ${TABLE}.slug ;;
  }

  dimension: source_url {
    type: string
    sql: ${TABLE}.source_url ;;
  }

  dimension: spotlight {
    type: string
    sql: ${TABLE}.spotlight ;;
  }

  dimension: staff_pick {
    type: string
    sql: ${TABLE}.staff_pick ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension_group: state_changed_at {
    type: time
    timeframes: [date,month,year]
    datatype: epoch
    sql: CAST(${TABLE}.state_changed_at AS INT64) ;;
  }

  dimension: static_usd_rate {
    type: string
    sql: ${TABLE}.static_usd_rate ;;
  }

  dimension: _urls_json {
    type: string
    sql: ${TABLE}.urls ;;
  }

  dimension: home_url {
    type: string
    sql: JSON_EXTRACT_SCALAR(${_urls_json}, "$.web.project") ;;
  }

  dimension: usd_pledged {
    type: number
    value_format: "$#,##0.00"
    sql: CAST(${TABLE}.usd_pledged AS FLOAT64);;
  }

  dimension: funding_difference {
    group_label: "Funding Success"
    type: number
    value_format: "$#,##0.00"
    sql: ${pledged} - ${goal};;
  }

  dimension: funding_percent {
    group_label: "Funding Success"
    type: number
    value_format_name: percent_1
    sql: ${pledged}/${goal} ;;
  }

  dimension: age_days {
    type: number
    sql: (CAST(${TABLE}.deadline AS INT64) - CAST(${TABLE}.launched_at AS INT64))/86400;;
  }

  measure: count {
    type: count
    drill_fields: [id, name]
  }
}
