using DelimitedFiles

function total_distance_eachline(filename)
    total_distance = 0
    for line in eachline(filename)
      try
        a, b = split(line)
        x = parse(Int, a)
        y = parse(Int, b)
        total_distance += abs(x - y) # Distance between x and y in each pair
      catch e
        println("Error parsing line: $line. Error: $e")
      end
    end
    return total_distance
  end

  function total_distance_readdlm(filename)
    data = readdlm(filename, Int)
    total_distance = sum(abs.(data[:,1] - data[:,2]))
    return total_distance
  end

  function paired_distance(filename)
    data = readdlm(filename, Int)
    left_column = sort(data[:,1])
    right_column = sort(data[:,2])
    total_distance = sum(abs.(left_column[:,1] - right_column[:,1]))
    return total_distance
end

filename = "inputs/day1-input.txt"
result = paired_distance(filename)
println("Total paired distance: ", result)


function calculate_similarity(filename)
    data = readdlm(filename, Int)
    left_counts = counts(data[:,1])
    right_counts = counts(data[:,2])
    total_similarity = 0
    unique_left = unique(data[:,1])
    for num in unique_left
        right_occurrences = get(right_counts, num, 0) #Handle cases where num isn't in right_counts
        total_similarity += num * right_occurrences
    end
    return total_similarity
end

function counts(arr)
  counts_dict = Dict()
  for x in arr
    counts_dict[x] = get!(counts_dict,x,0) + 1
  end
  return counts_dict
end

similarity_score = calculate_similarity(filename)
println("Total similarity score: ", similarity_score)
