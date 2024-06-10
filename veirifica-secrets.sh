#!/bin/bash

# Diretório onde será iniciada a busca
BASE_DIR="configmaps"

# Verifica se o diretório existe
if [ ! -d "$BASE_DIR" ]; then
  echo "O diretório $BASE_DIR não existe."
  exit 1
fi

# Função para verificar o conteúdo dos arquivos prod.yaml
check_fretebras() {
  local dir="$1"
  local file="$dir/prod.yaml"

  if [ -f "$file" ]; then
    if grep -q "fretebras.com.br" "$file"; then
      echo "Encontrado 'fretebras.com.br' em $file"
      exit 1
    fi
  fi
}

# Percorre todas as subpastas dentro de configmaps
for subdir in "$BASE_DIR"/*; do
  if [ -d "$subdir" ]; then
    check_fretebras "$subdir"
  fi
done

# Se não encontrar a string, o script termina com sucesso
echo "Ne
