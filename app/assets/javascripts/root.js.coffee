linker = ->
  $("a.linker").click ->
    data =
      matrix: $("#game_matrix").val()
      horizontal: $(this).attr("horizontal")
      vertical: $(this).attr("vertical")
      play: true

    $("#game").load $(location).attr("href") + " #game", data,  ->
      linker()

$(document).ready ->
  linker()
