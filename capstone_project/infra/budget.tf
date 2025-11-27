
# resource "azapi_resource" "budget" {
#  type      = "Microsoft.Consumption/budgets@2021-10-01"
#  name      = "monthly-budget"
#  parent_id = azurerm_resource_group.rg.id

#  body = jsonencode({
#    properties = {
#      amount    = 500 # monthly budget (INR or USD depending on subscription)
#      timeGrain = "Monthly"
#      timePeriod = {
#        startDate = "2025-01-01"
#        endDate   = "2026-01-01"
#      }
#      category = "Cost"
#      notifications = {
#        actual_greater_than_80 = {
#          enabled       = true
#          operator      = "GreaterThan"
#          threshold     = 80
#          contactEmails = ["ram@example.com"]
#          contactGroups = []
#          contactRoles  = []
#        }
#      }
#    }
#  })
#}

