{
  key = FILENAME " ||";
  for (i = 1; i < NF; ++i) {
    n = i+1;
    if ($n ~ /seconds/) {
      metric[key] += $i;
      count[key] += 1;
      squares[key] += $i * $i;
    }
    key = key " " $i;
  }
}

END {
  print " PARAM || no optimized || optimized || %";
  for (key in metric) {
    mean = metric[key] / count[key];
    mean_sq = squares[key] / count[key];
    sq_mean = mean * mean;

    suf = ""
    if (key ~ /NOOPT/) {
      comp_key = key
      gsub("NOOPT", "OPT", comp_key);
      if (count[comp_key] ) {
        mean_comp = metric[comp_key] / count[comp_key];
        mean_sq_comp = squares[comp_key] / count[comp_key];
        sq_mean_comp = mean_comp * mean_comp;
        if (mean_comp) {
          suf = " || " (100.0 * mean / mean_comp - 100.0) " %"
        }
        line_int = mean " +- " sqrt(mean_sq - sq_mean);
        line_comp = mean_comp " +- " sqrt(mean_sq_comp - sq_mean_comp);
        printf("%s = %s | %s %s\n", key, line_int, line_comp, suf);
      }
    }
  }
}
