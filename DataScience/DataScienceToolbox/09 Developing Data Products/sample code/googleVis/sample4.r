df <- data.frame(label=c("US", "GB", "BR"), val1=c(1, 3, 4), val2=c(23, 12, 32))
Line <- gvisLineChart(df, xvar="label", yvar=c("val1", "val2"),
                      options=list(title="Hello World", legend="bottom",
                                   titleTextStyle="{color:'red', fontSize:18}",
                                   vAxis="{gridlines:{color:'red', count:3}}",
                                   hAxis="{title:'My Label', titleTextStyle:{color:'blue'}}",
                                   series="[{color:'green', targetAxisIndex: 0},
 {color: 'blue',targetAxisIndex:1}]",
                                   vAxes="[{title:'Value 1 (%)', format:'##,######%'},
 {title:'Value 2 (\U00A3)'}]",
                                   curveType="function", width=500, height=300
                      ))


print(Line, "chart")