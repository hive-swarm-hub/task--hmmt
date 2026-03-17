#!/usr/bin/env bash
set -euo pipefail
mkdir -p data
echo "Downloading HMMT Feb 2025..."
python3 -c "
from datasets import load_dataset
import json, pathlib
ds = load_dataset('MathArena/hmmt_feb_2025', split='train')
out = pathlib.Path('data/test.jsonl')
with out.open('w') as f:
    for row in ds:
        f.write(json.dumps({'question': row['problem'], 'answer': str(row['answer'])}) + '\n')
print(f'Wrote {len(ds)} problems to {out}')
"
echo "Done. $(wc -l < data/test.jsonl) problems"
