defmodule TRC do
  # This is the function that must be called to apply the algorithm
  def apply_closure_algorithm(set_a, graph_r) do
    # First, generate the reflexive list
    reflexive_list = get_reflexive_graph(set_a)
    # Tgenm generating the transitive list
    transitive_list = graph_r
      |> find_edges()
      |> group_edges()
    
    # Generating reflexive-transitive list
    merge_graphs(reflexive_list, transitive_list)
  end

  # Create a node, with {x, y}
  def create_node(x, y) do
    {x, y}
  end

  # Generates a new graph expanding R with the reflexive
  def get_reflexive_graph(set_a) do
    set_a
    |> Enum.map(fn element -> create_node(element, element) end)
  end

  # Merge two graphs, ignoring the duplicates
  def merge_graphs(graph_a, graph_b) do
    Enum.concat(graph_a, graph_b)
      |> Enum.uniq
  end

  def check_value_edge(curr_key, edges, key, value) do
    if curr_key == key do
      Enum.concat(edges, [value])
    else
      edges
        |> Enum.concat(
          edges
          |> Enum.find(fn elem -> elem == key end)
          |> fn found -> found != nil && [value] || [] end.()
        )
    end
  end

  def merge_list_maps(list_maps) do
    merge_list_maps(list_maps, %{})
  end 
  # Ending case when list is empty
  def merge_list_maps([], merged_maps) do
    merged_maps
  end
  # The loop case
  def merge_list_maps(list_maps, merged_maps) do
    # Getting first map
    first_map = List.first(list_maps)
    # Merging first map with merged maps
    new_merged_maps = Map.merge(merged_maps, first_map)
    # Looping
    merge_list_maps(List.delete_at(list_maps, 0), new_merged_maps)
  end

  # Finding edges on a graph
  def find_edges(graph_r) do
    find_edges(graph_r, %{})
  end
  # Defining finish situation do
  def find_edges([], final_map) do
    final_map
  end
  # The loop situation
  def find_edges(graph_r, final_map) do
    {origin, destiny} = List.first(graph_r)

    new_map = final_map
      # Adding empty array with origin, if not exist
      |> Map.put_new(origin, [])
      # Adding new edges
      |> Enum.map(fn {k, v} ->
        %{k => check_value_edge(k, v, origin, destiny)}
      end)
      # Mergint list of maps
      |> merge_list_maps()

    find_edges(List.delete_at(graph_r, 0), new_map)
  end

  def group_edges(graph_r) do
    graph_r
    |> Enum.map(fn {key, values} ->
      # Generating all transitions
      Enum.map(values, fn value -> {key, value} end)
    end)
    # Flatting transitions into one array
    |> Enum.flat_map(fn x -> x end)
  end
end
