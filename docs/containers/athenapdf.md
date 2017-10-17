# AthenaPDF

AthenaPDF is a drop-in replacement for wkhtmltopdf

Usage:

```bash
$ curl http://athenapdf:8080/convert\?auth\=wodby-athenapdf\&url\=http://google.com/ |> out.pdf
```

## Configuration

Configuration is possible via environment variables. See the full list of variables on [GitHub](https://github.com/arachnys/athenapdf/blob/master/weaver/conf/sample.env).