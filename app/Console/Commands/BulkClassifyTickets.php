<?php

namespace App\Console\Commands;

use App\Jobs\ClassifyTicket;
use App\Models\Ticket;
use Illuminate\Console\Command;

class BulkClassifyTickets extends Command
{
    protected $signature = 'tickets:bulk-classify {--limit=10}';
    protected $description = 'Classify unclassified tickets in bulk';

    public function handle(): void
    {
        $limit = $this->option('limit');
        $tickets = Ticket::whereNull('category')
            ->orWhere('category', '')
            ->limit($limit)
            ->get();

        if ($tickets->isEmpty()) {
            $this->info('No unclassified tickets found.');
            return;
        }

        $this->info("Classifying {$tickets->count()} tickets...");
        
        $progressBar = $this->output->createProgressBar($tickets->count());
        $progressBar->start();

        foreach ($tickets as $ticket) {
            ClassifyTicket::dispatch($ticket);
            $progressBar->advance();
        }

        $progressBar->finish();
        $this->info("\nClassification jobs dispatched successfully!");
    }
}