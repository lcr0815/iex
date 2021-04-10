defmodule Identicon do
  @moduledoc """
  Documentation for `Identicon`.
  """

  @doc """
  Identicon.main function

  ## Examples

      iex> Identicon.main("asdf")

  """

  #MAIN/STRING
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_odd_squares
    |> build_pixel_map
    |> draw_image
    |> save_image(input)

  end
    
  #SAVE IMAGE
  def save_image(image, filename) do
    File.write("#{filename}.png", image)
  end

  def draw_image(%Identicon.Image{color: color, pixel_map: pixel_map}) do

    image = :egd. create(250,250)  # this creates the canvas of size 250x250
    fill  = :egd.color(color)

    Enum.each pixel_map, fn ({start, stop}) ->
      :egd.filledRectangle(image, start, stop, fill)
    end

    :egd.render(image)

  end

  def build_pixel_map(%Identicon.Image{grid: grid} = image) do
    pixel_map = Enum.map grid, fn ({ _i, point }) ->
      horizontal = rem(point,5) * 50
      vertical = div(point, 5) * 50

      top_left = {horizontal, vertical}
      bottom_right = {horizontal + 50, vertical + 50}
    
      {top_left, bottom_right}
    end

    %Identicon.Image{image | pixel_map: pixel_map}

  end

  def filter_odd_squares(%Identicon.Image{grid: grid} = image) do
    #Enum.filter (grid, fn() -> end)
    grid = Enum.filter grid, fn({code, _rest}) ->
      rem(code, 2) == 0
    end

#    grid
    %Identicon.Image{image | grid: grid}
#    %Identicon.Image{image | color | grid}
#    image
  end

  #Hash_input COMPUTE MD5 HASH OF STRING
  def hash_input(input) do
    hex = :crypto.hash(:md5, input) |>
    :binary.bin_to_list

    %Identicon.Image{hex: hex}
  end

  #Pick_color PICK THE IMAGE COLOR
  def pick_color(%Identicon.Image{hex: [r, g, b | _rest]} = image) do
    %Identicon.Image{image | color: {r, g, b}} 
  end

  #BUILD SQUARES GRID
  def build_grid(%Identicon.Image{hex: hex} = image) do
    grid = hex
            |> Enum.chunk(3)
            |> Enum.map(&mirror_row/1)
            |> List.flatten
            |> Enum.with_index
    %Identicon.Image{image | grid: grid}
  end

  #[145,46,200]
  def mirror_row(row) do
    [first, second | _rest] = row
    row ++ [second, first]
  end

  #LIST OF NUMBERS BASED ON THE STRING
  def numbers_list(input) do
    "the list of numbers #{input}"
  end

  #CONVERT GRID TO IMAGE
  def convert_grid_to_image() do
    "here to convert the grid to image"
  end

end
