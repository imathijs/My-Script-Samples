#!/bin/bash

# Aantal iteraties
aantal_iteraties=10

# Aantal batches per iteratie
aantal_batches=10

# Startwaarde voor batches
start_batch=1

# Lus uitvoeren
for (( i = 1; i <= $aantal_iteraties; i++ )); do
	echo "Iteratie: $i"
	
	# Verwerking van batches
	for (( j = $start_batch; j <= ($start_batch + $aantal_batches - 1); j++ )); do
		echo "Verwerking van batch: $j"
		# Voer hier de gewenste acties uit voor elke batch
		# ...
		
		sleep 1 # Tijdelijke pauze van 1 seconde tussen de batches (optioneel)
	done
	
	start_batch=$((start_batch + aantal_batches))
done