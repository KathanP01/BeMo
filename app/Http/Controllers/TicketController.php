<?php

namespace App\Http\Controllers;

use App\Jobs\ClassifyTicket;
use App\Models\Ticket;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class TicketController extends Controller
{
    public function index(Request $request): JsonResponse
    {
        $query = Ticket::query();
        
        // Filter by status
        if ($request->has('status') && $request->status !== 'all') {
            $query->where('status', $request->status);
        }
        
        // Filter by category
        if ($request->has('category') && $request->category !== 'all') {
            $query->where('category', $request->category);
        }
        
        // Search
        if ($request->has('search') && !empty($request->search)) {
            $search = $request->search;
            $query->where(function($q) use ($search) {
                $q->where('subject', 'like', "%{$search}%")
                ->orWhere('body', 'like', "%{$search}%");
            });
        }
        
        // Pagination
        $perPage = $request->get('per_page', 10);
        $tickets = $query->orderBy('created_at', 'desc')->paginate($perPage);
        
        return response()->json($tickets);
    }

    public function store(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'subject' => 'required|string|max:255',
            'body' => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $ticket = Ticket::create([
            'id' => (string) \Illuminate\Support\Str::ulid(),
            'subject' => $request->subject,
            'body' => $request->body,
            'status' => 'open',
        ]);

        ClassifyTicket::dispatch($ticket);

        return response()->json($ticket, 201);
    }

    public function show(Ticket $ticket): JsonResponse
    {
        return response()->json($ticket);
    }

    public function update(Request $request, Ticket $ticket): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'status' => 'sometimes|in:open,pending,resolved',
            'category' => 'sometimes|string|max:255',
            'note' => 'sometimes|string|nullable',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $ticket->update($request->only(['status', 'category', 'note']));

        return response()->json($ticket);
    }

    public function classify(Ticket $ticket): JsonResponse
    {
        ClassifyTicket::dispatch($ticket);

        return response()->json(['message' => 'Classification job dispatched']);
    }

    public function stats(): JsonResponse
    {
        $statusCounts = Ticket::selectRaw('status, count(*) as count')
            ->groupBy('status')
            ->pluck('count', 'status')
            ->toArray();
            
        $categoryCounts = Ticket::selectRaw('category, count(*) as count')
            ->whereNotNull('category')
            ->groupBy('category')
            ->pluck('count', 'category')
            ->toArray();
            
        return response()->json([
            'status' => $statusCounts,
            'categories' => $categoryCounts,
            'total' => Ticket::count(),
        ]);
    }
}