include: "base.view.lkml"

view: stats {
  extends: [base]
  extension: required

  dimension: cost_usd {
    type: number
    sql: (${cost} / 1000000) ;;
  }

  dimension: cost_per_click {
    type: number
    sql: ${cost}/(NULLIF(${clicks},0)) ;;
  }

  measure: total_cost {
    type: sum
    sql: ${cost_usd} ;;
    value_format_name: usd_0
  }

  measure: total_conversions {
    type: sum
    sql: ${conversions} ;;
    value_format_name: decimal_0
  }

  measure: total_impressions {
    type:  sum
    sql:  ${impressions} ;;
    drill_fields: [external_customer_id, total_impressions]
  }

  measure: total_interactions {
    type:  sum
    sql:  ${interactions} ;;
    drill_fields: [external_customer_id, total_impressions]
  }

  measure: total_clicks {
    type: sum
    sql: ${clicks} ;;
    value_format_name: decimal_0
  }

## Due the manner in which Looker compiles SQL queries, finding weighted averages in this instance is better accomplished through an aggregated measure
## rather than creating a new dimension to be aggregated over

  measure: average_interaction_rate {
    label: "Click Through Rate"
    type: number
    sql: ${total_clicks}*1.0/nullif(${total_impressions},0) ;;
    value_format_name: percent_2
  }

  measure: average_cost_per_conversion {
    label: "Cost per Conversion"
    type: number
    sql: ${total_cost}*1.0 / NULLIF(${total_conversions},0) ;;
    value_format_name: usd
  }

  measure: average_cost_per_click {
    label: "Cost per Click"
    type: number
    sql: ${total_cost}*1.0 / NULLIF(${total_clicks},0) ;;
    value_format_name: usd
  }

  measure: average_conversion_rate {
    label: "Conversion Rate"
    type: number
    sql: ${total_conversions}*1.0 / NULLIF(${total_clicks},0) ;;
    value_format_name: percent_2
  }
}