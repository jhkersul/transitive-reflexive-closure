defmodule TRCTest do
  use ExUnit.Case
  doctest TRC

  test "should create a node" do
    assert TRC.create_node(1, 2) == {1, 2}
  end

  test "should add the reflexive to graph" do
    set_a = [1, 2, 3]
    assert TRC.get_reflexive_graph(set_a) ==
      [{1, 1}, {2, 2}, {3, 3}]
  end

  test "should merge two graphs" do
    graph_a = [{1, 2}, {1, 1}]
    graph_b = [{2, 2}, {1, 2}]

    assert TRC.merge_graphs(graph_a, graph_b) ==
      [{1, 2}, {1, 1}, {2, 2}]
  end

  test "should check if is a edge" do
    edges = [2, 3]
    assert TRC.check_value_edge(1, edges, 3, 4) ==
      [2, 3, 4]
  end

  test "should check if is a edge 2" do
    edges = [3]
    assert TRC.check_value_edge(1, edges, 1, 4) ==
      [3, 4]
  end

  test "should merge a list of maps" do
    maps = [%{ 1 => [2, 3] }, %{ 2 => [3, 4] }]
    assert TRC.merge_list_maps(maps) ==
      %{ 1 => [2,3], 2 => [3,4] }
  end

  test "should get the edges of a graph" do
    graph_r = [{1, 2}, {2, 3}, {3, 4}]

    assert TRC.find_edges(graph_r) ==
      %{ 1 => [2, 3, 4], 2 => [3, 4], 3 => [4] }
  end

  test "should group the edges" do
    edges = %{ 2 => [3, 4], 4 => [5] }
    assert TRC.group_edges(edges) ==
      [{2, 3}, {2, 4}, {4, 5}]
  end

  test "should apply closure algorithm 1" do
    set_a = [1, 2, 3, 4]
    graph_r = [{1,2}, {2,3}, {3,4}]

    assert TRC.apply_closure_algorithm(set_a, graph_r) ==
      [{1,1}, {2,2}, {3,3}, {4,4}, {1,2}, {1,3}, {1,4}, {2,3}, {2,4}, {3,4}]
  end

  test "should apply closure algorithm 2" do
    set_a = [1, 2, 3, 4]
    graph_r = [{1,3}, {1,4}, {3,2}]

    assert TRC.apply_closure_algorithm(set_a, graph_r) ==
      [{1,1}, {2,2}, {3,3}, {4,4}, {1,3}, {1,4}, {1,2}, {3, 2}]
  end
end
