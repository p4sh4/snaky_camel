$LOAD_PATH.unshift File.expand_path("../../lib/", __FILE__)
require "rack/test"
require "json"
require "active_support/core_ext/hash/keys"
require "active_support/inflector"

require "snaky_camel"
