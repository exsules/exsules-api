class SearchSerializer < BaseSerializer
  attributes :first_name, :last_name

  def type
    "searches"
  end
end
