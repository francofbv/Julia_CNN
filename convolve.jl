using Random
using LinearAlgebra

# innit array

function define_matrix_dims()
  print("Please enter the number of rows in your matrix: ")
  matrix_n_string = readline()
  print("Please enter the number of columns in your matrix: ")
  matrix_m_string = readline()
  matrix_n, matrix_m = parse(Int, matrix_n_string), parse(Int, matrix_m_string)
  println("you entered: ", matrix_n, " x ", matrix_m)
  return matrix_n, matrix_m
end

function innit_matrix(n, m, padding)
  matrix = zeros(Float64, n, m)
  for row in padding:n - (padding - 1)
    for column in padding:m - (padding - 1)
      matrix[row, column] = (2.0 * rand(5, 5) .- 1.0)
    end
  end
  return matrix
end

function innit_kernel(n, m)
  matrix = zeros(Int, n, m)
  for row in 1:n 
    for column in 1:m 
      matrix[row, column] = rand(1:255)
    end
  end
  return matrix
  
end

function define_kernel_dims()
  print("Please enter the number of rows in your kernel: ")
  matrix_n_string = readline()
  print("Please enter the number of columns in your kernel: ")
  matrix_m_string = readline()
  matrix_n, matrix_m = parse(Int, matrix_n_string), parse(Int, matrix_m_string)
  println("you entered: ", matrix_n, " x ", matrix_m)
  return matrix_n, matrix_m
end

function print_matrix(matrix)
  n = size(matrix, 1)
  m = size(matrix, 2)
  for row in 1:n
    print("[")
    for column in 1:m
      print(matrix[row, column], ", ")
    end
    println("]")
  end
end

function define_stride()
  print("Plese define the stride for this convolution: ")
  stride_str = readline()
  stride = parse(Int, stride_str)
  println("You entered: ", stride)
  return stride
end

function define_padding()
  print("Please define the padding for this convolution: ")
  padding_str = readline()
  stride = parse(Int, padding_str)
  return stride
end

function convolve_matrix(matrix, kernel, stride, matrix_n, matrix_m, kernel_n, kernel_m)
  row_iters, column_iters = (matrix_n ÷ stride) + 1, (matrix_m ÷ stride) + 1
  convolved_matrix_n = convolved_matrix_m = 26
  convolved_matrix = zeros(Float64, convolved_matrix_n, convolved_matrix_m)
  convolution_matrix_row = 1
  convolution_matrix_col = 1
  for row in kernel_n:stride:matrix_n
    for column in kernel_m:stride:matrix_m
      sub_matrix = matrix[row - (kernel_n - 1):row, column - (kernel_m - 1):column]
      convolved_matrix[convolution_matrix_row, convolution_matrix_col] = dot(sub_matrix, kernel)
      convolution_matrix_col += 1
    end
      convolution_matrix_col = 1
      convolution_matrix_row += 1
  end
  return convolved_matrix
end

# matrix_n, matrix_m = define_matrix_dims() 
# padding = define_padding() + 1
matrix_n = matrix_m = 28
kernel_n = kernel_m = 3
stride = 1
padding = 1
matrix = innit_matrix(matrix_n, matrix_m, padding)
print_matrix(matrix)
# kernel_n, kernel_m = define_kernel_dims()
kernel = innit_kernel(kernel_n, kernel_m)
# stride = define_stride()
convolved_matrix = convolve_matrix(matrix, kernel, stride, matrix_n, matrix_m, kernel_n, kernel_m)
# print_matrix(convolved_matrix)
# println(size(convolved_matrix))
# println()
# println(convolved_matrix)
