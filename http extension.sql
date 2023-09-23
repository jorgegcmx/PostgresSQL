SELECT content::json->'data' as respuestaWS-->>'body' 
  FROM http((
           'POST',
           'url',
            ARRAY[http_header('Authorization','Basic ')],
           'application/json',
           '{"params":"value"}'
        )::http_request);
