echo "Ejecutar en R: spec(df_t)"
echo "Escribiendo col_types.out"
sed 's!^.*= col_!!;s!\(.\).*$!\1!;s!d!T!g' col_types.txt | tr '\n' '.' | sed 's!\.!!g' > col_types.out
echo "Fin de script"
