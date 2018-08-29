
# {
#   query {
#     lines {
#       phone_number
#       person {
#         [name_first
#         name_last
#         business {
#           subdomain
#         }]

#       }
#     }
#   }
# }
# #####################################################################################################################

# test = "{\"query\":{\"collection\":{\"lines\":{\"_sub\":[\"person_id\",\"phone_number\",\"country_id\",{\"devices\":{\"_sub\":[\"imei\",\"ref_device_id\",{\"person\":{\"_sub\":[\"email\",\"employee_id\",\"fullName\"]}}]}}]}}}}"
{
  query: {
    collection: {
      lines: {
        args: {},
        _attrs: [],
        devices
      }
    }
  }
}
# {
#   query: {
#     collection: {
#       name: true || "asdfasdf" || false || []

#     }
#   }
# }


# {
#   query: {
#     collection: {
#       hero: {
#         _args: {},
#         _attrs: [ "name" ],
#         _relations: {
#           friends: {
#             _attrs: ["name"],
#             _relations: {}
#           }
#         }
#       },
#       villain: {
#       },
#       innocent_bystander: {}
#     }
#   }
# }

{
  query: {
    collection: {
      lines: {
        _args: {id: 1},
        _attrs: ["phone_number", "label"],
        device: {
          _args: {id: 2},
          _attrs: ["imei", "msn"],
          person: {
            _attrs: ["name_first", "name_last"]
          }
        }
      }
    }
  }
}




{
  query: {
    _relations:{
      collection: {
        _relations: {

        }
        lines: {
          _args: {},
          _attrsk
          _relations: {
            device: {
              _relations: {
                person: {
                  _attrs: ["email", "employee_id", "fullName"]
                }
              },
              _attrs: [
                "imei",
                "ref_device_id"
              ]
            }
          },
          _attrs: [
            "person_id",
            "phone_number",
            "country_id"
          ]
        }
      }
    }
  }
}

# test = "{\"query\":{\"collection\":{\"lines\":{\"_sub\":[\"person_id\",\"phone_number\",\"country_id\",{\"devices\":{\"_sub\":[\"imei\",\"ref_device_id\"]}}]}}}}"


# #####################################################################################################################

# {
#   query: {
#     collection: {
#       lines: {
#         __body: [
#           "charges",
#           "phone_number",
#           "id",
#           "country_id",
#           {
#             person: {
#               __sub: [
#                 "email",
#                 "fullName",
#                 {
#                   devices: {
#                     __args: {},
#                     __sub: ["imei", "id"]
#                   }
#                 }
#               ]

#             }
#           }

#         ]
#       }
#     }
#   }
# }
