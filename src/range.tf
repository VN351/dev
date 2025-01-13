locals {
  rc_list_01_to_99 = [
    for i in range(1, 100) : format("rc%02d", i)
  ]

  rc_list_01_to_96_filtered = [
    for i in range(1, 97) : format("rc%02d", i)
    if (
      i == 19
      ||
      (i % 10 != 0) &&
      (i % 10 != 7) &&
      (i % 10 != 8) &&
      (i % 10 != 9)
    )
  ]
}
